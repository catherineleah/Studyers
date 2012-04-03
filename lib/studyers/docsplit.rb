# encoding: utf-8

unless defined? Docsplit
  begin
    require 'docsplit'
  rescue LoadError
    puts "WARNING: Failed to require docsplit, document processing may fail!"
  end
end

module Studyers
  module Docsplit
    VERSION = 0.1

    def length
      ::Docsplit.extract_length(current_path)
    end


    def extract_images
      ::Docsplit.extract_images(current_path, :size => %w{1000x}, :format => :png, output: output_path)
      self
    end

    def extract_text
      ::Docsplit.extract_text(self.pdf, :ocr => true, output: output_path)
      self
    end


    # def process_file       
    #   self.create_pdf
    #   self.extract_images
    # end
    private

    def output_path
      "public/#{store_dir}"
    end
  end
end