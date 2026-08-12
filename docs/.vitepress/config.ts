import { defineConfig } from 'vitepress'

export default defineConfig({
  title: 'VitePress Docker Starter',
  description: 'VitePress running in Docker, from dev to production',

  // the production side of this is try_files in nginx.conf
  cleanUrls: true,

  // the guide links this site's own localhost URLs — don't fail the build on them
  ignoreDeadLinks: 'localhostLinks',

  themeConfig: {
    nav: [
      { text: 'Guide', link: '/guide/' },
      { text: 'Markdown Demo', link: '/markdown' }
    ],
    sidebar: [
      { text: 'Overview', link: '/guide/' },
      { text: 'Getting Started', link: '/guide/getting-started' },
      { text: 'Markdown Demo', link: '/markdown' }
    ],
    socialLinks: [{ icon: 'github', link: 'https://github.com/brc-dd/vitepress-docker-starter' }],
    editLink: { pattern: 'https://github.com/brc-dd/vitepress-docker-starter/edit/main/docs/:path' }
  }
})
