# Taken from the AsciiDoctor extensions lab
# https://github.com/asciidoctor/asciidoctor-extensions-lab

RUBY_ENGINE == 'opal' ? (require 'glob-include-processor/extension') : (require_relative 'glob-include-processor/extension')

Asciidoctor::Extensions.register do
  include_processor GlobIncludeProcessor
end
