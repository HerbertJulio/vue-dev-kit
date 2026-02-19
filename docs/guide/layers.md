# Responsibility Layers

Each layer in the architecture has a single, well-defined responsibility.

## Service — Pure HTTP

Services make the HTTP request. Nothing else.

```typescript
// services/marketplace-service.ts
import { api } from '@/shared/services/api-client'
import type {
  MarketplaceListResponse,
  MarketplaceItemResponse,
} from '../types/marketplace.types'

export const marketplaceService = {
  list(params: { page: number; pageSize: number; search?: string }) {
    return api.get<MarketplaceListResponse>('/marketplace', { params })
  },

  getById(id: string) {
    return api.get<MarketplaceItemResponse>(`/marketplace/${id}`)
  },

  create(payload: CreateMarketplacePayload) {
    return api.post<MarketplaceItemResponse>('/marketplace', payload)
  },

  delete(id: string) {
    return api.delete(`/marketplace/${id}`)
  },
}
```

**Rules:**
- ✅ HTTP calls with typed request/response
- ✅ One file per domain/resource
- ✅ Export as object with methods
- ❌ No try/catch (caller handles errors)
- ❌ No data transformation (adapter does this)
- ❌ No business logic
- ❌ No store/composable access

## Adapter — Contract Parsers

Adapters transform data between API format and app format. They are **pure functions** with no side effects.

```typescript
// adapters/marketplace-adapter.ts
import type { MarketplaceItemResponse } from '../types/marketplace.types'
import type { MarketplaceItem } from '../types/marketplace.contracts'

export const marketplaceAdapter = {
  // Inbound: API → App
  toMarketplaceItem(response: MarketplaceItemResponse): MarketplaceItem {
    return {
      id: response.uuid,
      name: response.name,
      vendor: response.vendor_name,
      category: response.category_slug,
      price: response.price_cents / 100,
      isActive: response.status === 'active',
      createdAt: new Date(response.created_at),
      updatedAt: new Date(response.updated_at),
    }
  },

  // Outbound: App → API
  toCreatePayload(item: CreateMarketplaceInput): CreateMarketplacePayload {
    return {
      name: item.name,
      vendor_name: item.vendor,
      category_slug: item.category,
      price_cents: Math.round(item.price * 100),
    }
  },
}
```

**Rules:**
- ✅ Pure functions (input → output)
- ✅ Bidirectional: API → App (inbound) and App → API (outbound)
- ✅ Rename fields (snake_case → camelCase)
- ✅ Convert types (string → Date, cents → decimal, status → boolean)
- ❌ No HTTP calls
- ❌ No store/composable access

## Types and Contracts

Two separate files for the same resource:

```typescript
// types/marketplace.types.ts — Exact API response (snake_case)
export interface MarketplaceItemResponse {
  uuid: string
  name: string
  vendor_name: string
  category_slug: string
  price_cents: number
  status: 'active' | 'inactive' | 'pending'
  created_at: string
  updated_at: string
}

// types/marketplace.contracts.ts — App contract (camelCase)
export interface MarketplaceItem {
  id: string
  name: string
  vendor: string
  category: string
  price: number        // in currency, not cents
  isActive: boolean    // derived from status
  createdAt: Date
  updatedAt: Date
}
```

## Composable — Orchestration

Composables connect everything: call service, pass through adapter, manage loading/error, expose reactive data.

```typescript
// composables/useMarketplaceList.ts
import { computed, type MaybeRef, toValue } from 'vue'
import { useQuery, keepPreviousData } from '@tanstack/vue-query'
import { marketplaceService } from '../services/marketplace-service'
import { marketplaceAdapter } from '../adapters/marketplace-adapter'

export function useMarketplaceList(options: {
  page: MaybeRef<number>
  pageSize?: MaybeRef<number>
  search?: MaybeRef<string>
}) {
  const page = computed(() => toValue(options.page))
  const pageSize = computed(() => toValue(options.pageSize) ?? 20)
  const search = computed(() => toValue(options.search) ?? '')

  const { data, isLoading, isFetching, error, refetch } = useQuery({
    queryKey: computed(() => [
      'marketplace', 'list',
      { page: page.value, pageSize: pageSize.value, search: search.value },
    ]),
    queryFn: async () => {
      const response = await marketplaceService.list({
        page: page.value,
        pageSize: pageSize.value,
        search: search.value,
      })
      return marketplaceAdapter.toMarketplaceList(response.data)
    },
    staleTime: 5 * 60 * 1000,
    placeholderData: keepPreviousData,
  })

  const items = computed(() => data.value?.items ?? [])
  const totalPages = computed(() => data.value?.totalPages ?? 0)
  const isEmpty = computed(() => !isLoading.value && items.value.length === 0)

  return { items, totalPages, isLoading, isFetching, isEmpty, error, refetch }
}
```

**Rules:**
- ✅ Orchestrate: service → adapter → reactive data
- ✅ Manage loading, error, empty states
- ✅ Return refs/computed (never raw values)
- ✅ Named `useXxx`
- ❌ No template/rendering
- ❌ No direct API access

## Pinia Store — Client State Only

Pinia is for state that **does not come from the server**: UI state, filters, preferences.

```typescript
// stores/marketplace-store.ts
import { defineStore } from 'pinia'
import { ref, computed, readonly } from 'vue'

export const useMarketplaceStore = defineStore('marketplace', () => {
  const selectedCategory = ref<string | null>(null)
  const viewMode = ref<'grid' | 'list'>('grid')
  const searchQuery = ref('')

  const hasActiveFilters = computed(() =>
    !!selectedCategory.value || !!searchQuery.value
  )

  function clearFilters() {
    selectedCategory.value = null
    searchQuery.value = ''
  }

  return {
    selectedCategory: readonly(selectedCategory),
    viewMode: readonly(viewMode),
    searchQuery,
    hasActiveFilters,
    clearFilters,
  }
})
```

**Rules:**
- ✅ Client state only (UI, filters, preferences, session)
- ✅ Setup syntax
- ✅ `readonly()` on exposed state
- ✅ `storeToRefs()` when destructuring in components
- ❌ No server state (API data goes in Vue Query)
- ❌ No HTTP calls
