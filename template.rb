require 'fileutils'

def source_paths
  [File.expand_path(File.dirname(__FILE__))]
end

# Environment
copy_file 'Dockerfile'
copy_file 'docker-compose.yml'
# gems
copy_file 'Gemfile'
copy_file 'Gemfile.lock'
# webpack
copy_file 'package.json'
copy_file 'yarn.lock'
# misc
copy_file 'Procfile'
copy_file 'config/application.rb'
copy_file 'config/database.yml'
FileUtils.cp_r("#{File.expand_path(File.dirname(__FILE__))}/dev", 'dev')

# webpack
copy_file 'webpack.common.js'
copy_file 'webpack.dev.js'
copy_file 'webpack.prd.js'
copy_file 'lib/webpack_asset.rb'
copy_file 'app/helpers/webpack_bundle_helper.rb'
run 'rm -fR app/assets'
FileUtils.cp_r("#{File.expand_path(File.dirname(__FILE__))}/frontend", 'frontend')

# bulma integration
copy_file 'config/initializer/simple_form_bulma.rb'
copy_file 'lib/helper_models.rb'
copy_file 'lib/helper_models/html_menu_list.rb'
copy_file 'lib/helper_models/html_table.rb'
copy_file 'app/helpers/bulma_helper.rb'
copy_file 'app/helpers/bulma_menu_list_helper.rb'
copy_file 'app/helpers/bulma_table_helper.rb'

# templates
copy_file 'app/helpers/application_helper.rb'
copy_file 'app/views/layouts/application.html.haml'
copy_file 'app/views/layouts/naked.html.haml'
copy_file 'app/views/layouts/mailer.html.haml'
copy_file 'app/views/layouts/mailer.text.haml'
run 'find app/views -name "*.erb" -exec rm -f {} \;'

# root example
if !File.exists?('app/controller/home_controller.rb') ||
    yes? 'Do you want to create an example homepage?'
  route 'home#index'
  copy_file 'app/controllers/home_controller.rb'
  copy_file 'app/views/home/index.html.haml'
  copy_file 'config/locales/ja.yml'
end

# git
git :init
append_to_file '.gitignore' do
  '!/tmp/pids/'
  '!/tmp/pids/.keep'
  '!/tmp/sockets/'
  '!/tmp/sockets/.keep'
  'DS_Store'
  '*.bak'
end
