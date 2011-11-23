class Cardify::Admin::PhotosController < ModuleController

  component_info 'Cardify'

  permit 'cardify_manage'

  cms_admin_paths 'content', 'Cardify Photos' => {:action => 'index'}

  active_table :cardify_photo_table, CardifyPhoto,
    [ :check, 
      :image_id,
      :permalink,
      :title,
      :description
    ]

  def display_cardify_photo_table(display=true)
    active_table_action 'cardify_photo' do |act, ids|
      case act
      when 'delete'
        CardifyPhoto.destroy ids
      end
    end

    @tbl = cardify_photo_table_generate params

    render :partial => 'cardify_photo_table' if display
  end

  def index
    cms_page_path ['Content'], 'Cardify Photos'
    
    display_cardify_photo_table(false)
  end


  def edit
    @photo = CardifyPhoto.find_by_id(params[:path][0]) || CardifyPhoto.new
    cms_page_path ['Content', 'Cardify Photos'], @photo.id ? 'Edit Photo' : 'Create Photo'

    if request.post? 
      if params[:commit] && @photo.update_attributes(params[:cardify_photo])
        flash[:notice] = "Photo Saved"
        redirect_to :action => 'index'
      else
        redirect_to :action => 'index'
      end
    end

  end

  
end




