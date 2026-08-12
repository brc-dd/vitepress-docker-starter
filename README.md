# VitePress Docker Starter

A small [VitePress 2](https://vitepress.dev/) starter that runs entirely in Docker. It includes a hot-reloading development server and an unprivileged nginx production image, so the host only needs Docker with Compose v2.

## Development

```sh
docker compose up dev
```

Open <http://localhost:5173>. Changes under `docs/` reload automatically.

`node_modules` lives in a named volume and re-syncs with the lockfile on every container start. After changing `package.json`, `pnpm-lock.yaml`, or `pnpm-workspace.yaml` — or pulling such changes — restart:

```sh
docker compose restart dev
```

`docker compose up dev --watch` restarts automatically instead.

## Dependencies

Run pnpm through the dev service; `package.json` and `pnpm-lock.yaml` are updated in your checkout:

```sh
docker compose run --rm dev pnpm add -D markdown-it-footnote
```

Any pnpm command works the same way — `pnpm remove`, `pnpm update`, or `pnpm docs:build` for a static build into `docs/.vitepress/dist`. `docker compose down -v` resets all volumes.

## Production

```sh
docker compose up prod --build
```

Open <http://localhost:8080>.

The image builds the site from the committed lockfile and serves only the generated files with nginx. It supports VitePress clean URLs, directory indexes, real 404 responses, gzip, and long-lived caching for hashed assets.

## Project structure

| Path | Purpose |
| --- | --- |
| `docs/` | Site content and VitePress configuration |
| `Dockerfile` | Development, build, and production images |
| `compose.yaml` | Development and production services |
| `nginx.conf` | Production routing, caching, compression, and headers |
| `pnpm-workspace.yaml` | pnpm settings |

Edit `docs/.vitepress/config.ts` to change the site configuration, or add Markdown files under `docs/` to add content.
