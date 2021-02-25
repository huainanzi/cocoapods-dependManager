module Pod
  class Command
    class Dependmanager
      class List < Dependmanager
        self.summary = "list dependencies"

        self.description = <<-DESC
          List all dependencies in working podfile
        DESC

        def self.options
          [
            ['--target=TARGET', 'list all dependencies in `TARGET`'],
            ['--podfile=PODFILE', 'podfile name, defalut Podfile'],
          ].concat(super)
        end

        def initialize(argv)
          @target = argv.option('target')
          @podfile_name = argv.option('podfile')
          super
        end

        def run
          podfile_path = ''
          if @podfile_name
            podfile_path = Pathname.pwd + @podfile_name 
          else
            podfile_path = Pathname.pwd + 'Podfile'  
          end
          target_definitions = Podfile.from_file(podfile_path).target_definitions
          if @target
            unless target_definitions.has_key?(@target)
              help! 'The target is not exist'
            else
              print_target_dependencies(target_definitions[@target])
            end
          else
            target_definitions.each do |name, definition|
              unless name == 'Pods'
                print_target_dependencies(definition)
              end
            end
          end
        end

        def print_target_dependencies(target_definition)
          UI.title "Target #{target_definition.name}" do
            target_definition.dependencies.each do |dependency|
              UI.puts "- #{dependency.to_s}"
            end
          end
          UI.puts "\n"
        end

      end
    end
  end
end
