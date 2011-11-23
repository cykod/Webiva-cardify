class Cardify::Admin::IconsController < ModuleController

  component_info 'Cardify'

  permit 'cardify_manage'

  cms_admin_paths 'content', 'Cardify Icons' => {:action => 'index'}

  active_table :cardify_icon_table, CardifyIcon,
    [ :check, 
      :image_id,
      :cardify_category_id
    ]

  def display_cardify_icon_table(display=true)
    active_table_action 'cardify_icon' do |act, ids|
      case act
      when 'delete'
        CardifyIcon.destroy ids
      end
    end

    @tbl = cardify_icon_table_generate params

    render :partial => 'cardify_icon_table' if display
  end

  def index
    cms_page_path ['Content'], 'Cardify Icons'
    
    display_cardify_icon_table(false)
  end


  def edit
    @icon = CardifyIcon.find_by_id(params[:path][0]) || CardifyIcon.new
    cms_page_path ['Content', 'Cardify Icons'], @icon.id ? 'Edit Icon' : 'Create Icon'

    if request.post? 
      if params[:commit] && @icon.update_attributes(params[:cardify_icon])
        flash[:notice] = "Icon Saved"
        redirect_to :action => 'index'
      else
        redirect_to :action => 'index'
      end
    end

  end

  
end




