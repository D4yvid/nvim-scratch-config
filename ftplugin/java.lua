local lsp = require 'lsp'

local jdtls = vim.fn.expand '$HOME/.local/share/jdtls'
local cache = vim.fn.stdpath('cache') .. '/jdtls'

lsp:start_lsp('java', {
	cmd = {
		'java',

		'-Declipse.application=org.eclipse.jdt.ls.core.id1',
		'-Dosgi.bundles.defaultStartLevel=4',
		'-Declipse.product=org.eclipse.jdt.ls.core.product',
		'-Dlog.protocol=true',
		'-Dlog.level=ALL',

		'-Xmx512M',
		'-Xms512M',

		'--add-modules=ALL-SYSTEM',
		'--add-opens', 'java.base/java.util=ALL-UNNAMED',
		'--add-opens', 'java.base/java.lang=ALL-UNNAMED',

		'-jar', jdtls .. '/plugins/org.eclipse.equinox.launcher_1.6.500.v20230717-2134.jar',
		'-configuration', jdtls .. '/config_linux',
		'-data', cache
	},

	on_attach = lsp.on_attach,
	root_dir = vim.loop.cwd()
})
