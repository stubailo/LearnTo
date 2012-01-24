require 'uri'

class Resource < ActiveRecord::Base
  validates :file_file_name, :presence => true, :if => lambda { |res| res.try(:file_type) =="upload" }
  validates :file_content_type, :presence => true, :if => lambda { |res| res.try(:file_type) =="upload" }
  validates :file_file_size, :presence => true, :if => lambda { |res| res.try(:file_type) =="upload" }
  validates :file_updated_at, :presence => true, :if => lambda { |res| res.try(:file_type) =="upload" }
  validates :name, :presence => true, :if => lambda { |res| res.try(:source_call) !="document" }
  validates :url, :presence => true, :if => lambda { |res| res.try(:source_call) =="link" }
  validates :user_id, :presence => true, :if => lambda { |res| res.try(:source_call) !="document" }
  validates :class_room_id, :presence => true, :if => lambda { |res| res.try(:source_call) !="document" }
  validates :file_type, :presence => true
  validates :doc_id, :presence => true, :if => lambda { |res| res.try(:source_call) =="document" }
  validates :source_call, :presence => true
  validates :order, :presence => true, :if => lambda { |res| res.try(:source_call) !="document" }
  validates :section_id, :presence => true, :if => lambda { |res| res.try(:source_call) !="document" }


  belongs_to :class_room
  belongs_to :user
  belongs_to :document
  belongs_to :resource
  belongs_to :section
  has_one :document
  
  if Rails.env == "production"
    has_attached_file :file, :styles => Proc.new { |a| a.instance.file_styles(a) }, 
      :storage => :s3, 
      :s3_credentials => "#{Rails.root}/config/s3.yml", 
      :path => "/:style/:id/:filename"
  else
    has_attached_file :file, :styles => Proc.new { |a| a.instance.file_styles(a) }
  end
  
  def file_styles(a)
    type = a.content_type
	if(type.start_with? "image")	
	  return { :medium => "300x300>", :thumb => "100x100>" }
	else
	  return {}
	end
  end
 
  # never change these names, or the order, ever :D
  TYPES = ['upload', 'link', 'document']


  validates_attachment_size :file, less_than: 10.megabyte

  def get_info

    audio_file_extensions = ['mp3']
    doc_file_extensions = ["doc", "docx", "xlsx", "xls", "ppt", "pptx", "pdf"]
    text_file_extensions = ["bsh", "c", "cc", "cpp", "cs", "csh", "cyc", "cv", "htm", "html",
        "java", "js", "m", "mxml", "perl", "pl", "pm", "py", "rb", "sh",
            "xhtml", "xml", "xsl", "txt"]
    image_file_extensions = ["jpg", "png", "jpeg", "gif"] 


    info = {}

    case self.file_type
    when "document"
       

    when "upload"
      
      #check environment to see if s3 or local storage
      if Rails.env == "production" 
        info[:s3] = is_s3 = true
      else
        info[:s3] = is_s3 = false
      end

      file_extension = File.extname(self.file.url.split("?")[0])

      if file_extension == ""
        if self.file.content_type.start_with? "text"
          info[:media_type] = "text"
        else
          info[:media_type] = "unknown"
        end
      else
        if audio_file_extensions.map{|x| "." + x}.include? file_extension
          info[:media_type] = "audio"
        elsif doc_file_extensions.map{|x| "." + x}.include? file_extension
          info[:media_type] = "doc"
        elsif text_file_extensions.map{|x| "." + x}.include? file_extension
          info[:media_type] = "text"
        elsif image_file_extensions.map{|x| "." + x}.include? file_extension
          info[:media_type] = "image"
        else
          info[:media_type] = "unknown"
        end
      end
      

    when "link"

      #parse URI
      uri = URI(self.url)
      
      #first, get the file extension, if there is one
      file_extension = File.extname(uri.path)

      if file_extension == ""
        #if no extension, try to find from domain
        if uri.host.include? "youtube.com" and uri.path.start_with? "/watch"
          info[:media_type] = "video"
          video_id = CGI.parse(uri.query)["v"][0]
          info[:video] = {:source => "youtube", :id => video_id}
        else
          info[:media_type] = "unknown"
        end
      else
        if audio_file_extensions.map{|x| "." + x}.include? file_extension
          info[:media_type] = "audio"
        elsif doc_file_extensions.map{|x| "." + x}.include? file_extension
          info[:media_type] = "doc"
        elsif text_file_extensions.map{|x| "." + x}.include? file_extension
          info[:media_type] = "text"
        elsif image_file_extensions.map{|x| "." + x}.include? file_extension
          info[:media_type] = "image"
        else
          info[:media_type] = "unknown"
        end
      end


    end

    return info
  end

end
