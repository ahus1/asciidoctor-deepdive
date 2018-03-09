require 'asciidoctor/extensions'
require 'text/hyphen'

include ::Asciidoctor

HyphenatorGerman = Text::Hyphen.new(:language => "de")

# ignore entities and things in pointy brackets
SegmentPcdataRx = /(?:(&[a-z]+;|<[^>]+>)|([^&<]+))/

def hyphenate string
  words = string.split(/[^[[:word:]]]+/).uniq
  if (words) then
    words.each do |word|
      hyphenatedWord = HyphenatorGerman.visualize word, '&#173;'
      string = string.gsub word, hyphenatedWord
    end
  end
  return string
end

module HyphenationExtension
  def content
    content = super
    case @content_model
      when :simple
        content.gsub(SegmentPcdataRx) { $2 ? (hyphenate $2) : $1 }
      else
        content
    end
  end

  def text
    content = super
    content.gsub(SegmentPcdataRx) { $2 ? (hyphenate $2) : $1 }
  end
end

class Asciidoctor::Block
  prepend HyphenationExtension
end
class Asciidoctor::ListItem
  prepend HyphenationExtension
end
class Asciidoctor::Table::Cell
  prepend HyphenationExtension
end

