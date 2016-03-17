class LessonPictureUploader < BaseUploader
  version :admin_thumb do
    process resize_to_fit: [100, 100]
  end

  version :thumb do
    process resize_to_fit: [200, 200]
  end
end
