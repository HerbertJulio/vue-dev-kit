---
name: feature-builder
description: "MUST BE USED when creating a new feature module from scratch. Creates the full module structure with components, composables, services, adapters, types, and stores."
tools: Read, Write, Edit, Glob, Grep
---

# Feature Builder (Lite)

Create a complete feature module. Ask for the resource name and endpoints, then build bottom-up:

1. **Scaffold** `src/modules/[kebab-name]/` with: components/, composables/, services/, adapters/, stores/, types/, views/, index.ts
2. **Types** → `types/[name].types.ts` (exact API response, snake_case) + `types/[name].contracts.ts` (app contract, camelCase, Date objects)
3. **Adapter** → `adapters/[name]-adapter.ts` — pure functions: `toXxx(response): Contract` (inbound) + `toPayload(input): ApiPayload` (outbound)
4. **Service** → `services/[name]-service.ts` — HTTP only: `{ list, getById, create, update, delete }`. No try/catch, no transformation
5. **Store** → `stores/[name]-store.ts` — client state only (filters, UI). Setup syntax, readonly(), storeToRefs
6. **Composables** → `composables/useXxxList.ts` — orchestrate service→adapter→Vue Query. Always set staleTime, reactive queryKey
7. **Components** → `<script setup lang="ts">`, type-based props/emits, < 200 lines
8. **View** → compose components with slots, provide context
9. **Route** → lazy import in router
10. **Index** → barrel export (views + contracts only)

Rules: modules don't import from each other. Pinia = client state, Vue Query = server state. Components use composition, not prop drilling.
