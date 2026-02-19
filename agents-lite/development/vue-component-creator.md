---
name: vue-component-creator
description: "MUST BE USED when creating new Vue components. Creates components following script setup, TypeScript, and composition pattern."
tools: Read, Write, Edit, Glob, Grep
---

# Vue Component Creator (Lite)

Create Vue 3 components with `<script setup lang="ts">`. Structure: imports → props (defineProps<T>) → emits (defineEmits<T>) → stores (storeToRefs) → composables → local state → computed → handlers.

Placement: feature component → `src/modules/[feature]/components/`, shared → `src/shared/components/`.

Rules: < 200 lines, type-based props/emits, no prop drilling (use slots + provide/inject), handle loading/error/empty states, PascalCase.vue naming. Extract logic > 20 lines to composable.
