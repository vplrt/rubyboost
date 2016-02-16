class CoursePictureUploader < BaseUploader
  version :admin_thumb do
    process resize_to_fit: [140, 100]
  end

  version :thumb do
    process resize_to_fit: [300, 300]
  end
end
