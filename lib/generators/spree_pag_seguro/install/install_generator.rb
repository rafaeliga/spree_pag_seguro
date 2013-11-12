module SpreePagSeguro
  module Generators
    class InstallGenerator < Rails::Generators::Base
      
      source_root File.expand_path("../../../../..", __FILE__)
      
      def add_stylesheets
        inject_into_file 'app/assets/stylesheets/store/all.css', " *= require store/spree_pag_seguro\n", :before => /\*\//, :verbose => true
        inject_into_file 'app/assets/stylesheets/admin/all.css', " *= require admin/spree_pag_seguro\n", :before => /\*\//, :verbose => true
      end
      
      def add_migrations
        run 'bundle exec rake railties:install:migrations FROM=spree_pag_seguro'
      end
      
      
      def run_migrations
        res = ask "Would you like to run the migrations now? [Y/n]"
        if res == "" || res.downcase == "y"
          run 'bundle exec rake db:migrate'
        else
          puts "Skiping rake db:migrate, don't forget to run it!"
        end
      end
    end
  end
end
