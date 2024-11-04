return {
  schemaStore = {
    enable = true,
    url = 'https://www.schemastore.org/api/json/catalog.json',
  },
  schemas = {
    kubernetes = '*.yaml',
    ['http://json.schemastore.org/github-workflow'] = '.github/workflows/*',
    ['http://json.schemastore.org/github-action'] = '.github/action.{yml,yaml}',
    ['http://json.schemastore.org/prettierrc'] = '.prettierrc.{yml,yaml}',
    ['http://json.schemastore.org/kustomization'] = 'kustomization.{yml,yaml}',
    ['https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json'] = '*docker-compose*.{yml,yaml}',
  },
  format = { enable = true },
  validate = true,
  completion = true,
  hover = true,
}
