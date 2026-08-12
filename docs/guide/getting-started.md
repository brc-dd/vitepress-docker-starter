# Getting Started

You only need Docker. Run everything from the repository root.

## Dev server

```sh
docker compose up dev
```

Open <http://localhost:5173> and start editing files under `docs/`.

Dependencies re-sync with the lockfile on every container start. After changing dependency files or pulling, restart:

```sh
docker compose restart dev
```

Add or remove packages through the container:

```sh
docker compose run --rm dev pnpm add -D '<package>'
```

## Production

```sh
docker compose up prod --build
```

Open <http://localhost:8080>.
