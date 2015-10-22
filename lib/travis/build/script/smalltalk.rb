module Travis
  module Build
    class Script
      class Smalltalk < Script
        DEFAULTS = {}

        def configure
          super
          sh.cmd 'sudo apt-get install --no-install-recommends libc6:i386 ' +
                   'libuuid1:i386', retry: true
        end

        def setup
          super
          sh.cmd "export PROJECT_HOME=\"$(pwd)\""
          sh.cmd "pushd $HOME"
          sh.cmd "wget -q -O filetreeCI.zip https://github.com/hpi-swa/filetreeCI/archive/master.zip"
          sh.cmd "unzip -q -o filetreeCI.zip"
          sh.cmd "pushd filetreeCI-*"
          sh.cmd "export FILETREE_CI_HOME=\"$(pwd)\""
          sh.cmd "$FILETREE_CI_HOME/run.sh"
          sh.cmd "popd; popd"
        end

      end
    end
  end
end
