Crie testes para o arquivo ou módulo especificado.

Alvo: $ARGUMENTS

## Passos

1. Analise o arquivo para entender o que testar.

2. Determine o tipo de teste:

### Adapter (prioridade alta – funções puras, fácil de testar)
```typescript
import { describe, it, expect } from 'vitest'
import { xxxAdapter } from '../adapters/xxx-adapter'

describe('xxxAdapter', () => {
  describe('toXxx', () => {
    it('should convert API response to app contract', () => {
      const response = { uuid: '123', field_name: 'test', created_at: '2024-01-01T00:00:00Z' }
      const result = xxxAdapter.toXxx(response)
      expect(result.id).toBe('123')
      expect(result.fieldName).toBe('test')
      expect(result.createdAt).toBeInstanceOf(Date)
    })
  })
})
```

### Composable (prioridade média)
```typescript
import { describe, it, expect, vi } from 'vitest'
import { flushPromises } from '@vue/test-utils'
import { useXxxList } from '../composables/useXxxList'
// Mock service
vi.mock('../services/xxx-service')
```

### Componente (prioridade média-baixa)
```typescript
import { describe, it, expect } from 'vitest'
import { mount } from '@vue/test-utils'
import XxxComponent from '../components/XxxComponent.vue'

describe('XxxComponent', () => {
  it('should render', () => {
    const wrapper = mount(XxxComponent, { props: { /* ... */ } })
    expect(wrapper.exists()).toBe(true)
  })
})
```

3. Crie o teste em `__tests__/NomeOriginal.spec.ts`.

4. Execute: `npx vitest run --reporter=verbose`
