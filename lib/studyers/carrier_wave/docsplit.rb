# encoding: utf-8

unless defined? Docsplit
  begin
    require 'docsplit'
  rescue LoadError
    puts "WARNING: Failed to require docsplit, document processing may fail!"
  end
end

module Studyers
  module CarrierWave

    module Docsplit
      VERSION = 0.1

      def pdf?
        current_path[-3,3] == 'pdf'
      end

      def pdf
        current_path[0..current_path.rindex('.')] + 'pdf'
      end

      def length
        ::Docsplit.extract_length(current_path)
      end

      def create_pdf
        ::Docsplit.extract_pdf(current_path, output: output_path) unless pdf?
        self
      end

      def extract_images
        ::Docsplit.extract_images(self.pdf, :size => %w{1000x}, :format => :png, output: output_path)
        #FileUtils.mv output_path + "180x", output_path + "small"
        #FileUtils.mv output_path + "700x", output_path + "normal"
        #FileUtils.rm output_path + "*.png"
        self
      end

      def extract_text
        ::Docsplit.extract_text(self.pdf, :ocr => true, output: output_path)
        self
      end

      private

      def output_path
        "public/#{store_dir}/"
      end
    end
  end
end