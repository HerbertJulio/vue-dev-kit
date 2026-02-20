import { defineConfig } from 'vitepress'
import { withMermaid } from 'vitepress-plugin-mermaid'

export default withMermaid(defineConfig({
  title: 'Vue Dev Kit',
  description: 'Development toolkit for Vue 3 projects with Claude Code',
  base: '/vue-dev-kit/',

  head: [
    ['link', { rel: 'icon', type: 'image/svg+xml', href: '/vue-dev-kit/logo.svg' }],
  ],

  themeConfig: {
    logo: '/logo.svg',
    siteTitle: 'Vue Dev Kit',

    nav: [
      { text: 'Guide', link: '/guide/introduction' },
      { text: 'Reference', link: '/reference/agents' },
      { text: 'Customization', link: '/customization/creating-agents' },
    ],

    sidebar: {
      '/guide/': [
        {
          text: 'Getting Started',
          items: [
            { text: 'Introduction', link: '/guide/introduction' },
            { text: 'Installation', link: '/guide/installation' },
            { text: 'Quick Start', link: '/guide/quick-start' },
          ],
        },
        {
          text: 'Architecture',
          items: [
            { text: 'Overview', link: '/guide/architecture' },
            { text: 'Layers', link: '/guide/layers' },
            { text: 'Components', link: '/guide/components' },
          ],
        },
      ],
      '/reference/': [
        {
          text: 'Reference',
          items: [
            { text: 'Agents', link: '/reference/agents' },
            { text: 'Slash Commands', link: '/reference/commands' },
            { text: 'Token Usage', link: '/reference/tokens' },
          ],
        },
      ],
      '/customization/': [
        {
          text: 'Customization',
          items: [
            { text: 'Creating Agents', link: '/customization/creating-agents' },
            { text: 'Creating Commands', link: '/customization/creating-commands' },
            { text: 'Editing Patterns', link: '/customization/editing-patterns' },
          ],
        },
      ],
    },

    socialLinks: [
      { icon: 'github', link: 'https://github.com/HerbertJulio/vue-dev-kit' },
    ],

    editLink: {
      pattern: 'https://github.com/HerbertJulio/vue-dev-kit/edit/main/docs/:path',
      text: 'Edit this page on GitHub',
    },

    footer: {
      message: 'Released under the MIT License.',
      copyright: 'Copyright © 2025-present',
    },

    search: {
      provider: 'local',
    },
  },

  mermaid: {
    theme: 'base',
    themeVariables: {
      primaryColor: '#42b883',
      primaryTextColor: '#213547',
      primaryBorderColor: '#42b883',
      lineColor: '#42b883',
      secondaryColor: '#35495e',
      tertiaryColor: '#f8f8f8',
    },
  },
}))
