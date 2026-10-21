# React + Expo + TypeScript Rules

OpenGeoForge reference clients use React + Expo + TypeScript, while the backend remains fully headless-capable.

## TypeScript

TypeScript must run in strict mode.

Hard rules:
- no implicit `any`;
- avoid explicit `any`; document unavoidable untyped boundaries;
- never use `as unknown as T` to silence errors;
- do not use `@ts-ignore`; use `@ts-expect-error` only with a documented reason;
- avoid non-null assertions when state can be modeled correctly;
- model nullable/optional values explicitly;
- prefer discriminated unions for async/edit state;
- use literal unions instead of magic strings;
- prefer `satisfies` when validating object shape without losing inference;
- do not manually duplicate generated OpenAPI DTOs without a reason.

Example:

```ts
type LoadState<T> =
  | { status: 'idle' }
  | { status: 'loading' }
  | { status: 'success'; data: T }
  | { status: 'error'; error: Error };
```

## React

Use function components and hooks.

Never:
- call hooks conditionally;
- mutate props/state;
- perform side effects during render;
- create a map engine instance during render;
- copy props/server data into state without a real reason;
- use array indexes as keys for reorderable/domain entities.

Use `useEffect` only to synchronize with external systems such as:
- map engines;
- subscriptions;
- native/browser APIs.

Every effect that registers resources/listeners must clean them up.

Do not use effects for derived state that can be calculated during render.

## Server state

Recommended:
- TanStack Query for server state when caching/invalidation is useful;
- `useState` / `useReducer` for local UI/edit state;
- Context only for narrow shared concerns;
- Zustand/Redux only after a real cross-feature requirement exists.

Do not mirror API collections into a global store by default.

## API client

All OpenGeoForge calls go through a typed API layer.

Prefer generated OpenAPI types/client.

Requirements:
- cancellation/AbortSignal;
- distinct handling for 401, 403, 409, 422, 429;
- no GeoServer internal URLs;
- no embedded credentials;
- no blind retry of non-idempotent writes.

## Performance

Do not render large GIS datasets as React component lists or one huge GeoJSON collection.

Use:
- MVT for large interactive vector data;
- WMTS for stable cached maps;
- viewport-bounded GeoJSON for smaller overlays/editing.

Memoization is not a default style. Use it for measured or structurally necessary cases.

## Testing

Test:
- pure geometry/data adapters;
- React behavior;
- API contracts;
- platform-specific map components;
- web E2E;
- native device flows;
- Point/LineString/Polygon/MultiPolygon/holes/invalid fixtures.
