class Cardify::Admin::ThemesController < ModuleController

  component_info 'Cardify'

  permit 'cardify_manage'

  cms_admin_paths 'content', 'Cardify Themes' => {:action => 'index'}

  active_table :cardify_theme_table, CardifyTheme,
    [ :check, 
      :image_id,
      :cardify_category_id
    ]

  def display_cardify_theme_table(display=true)
    active_table_action 'cardify_theme' do |act, ids|
      case act
      when 'delete'
        CardifyTheme.destroy ids
      end
    end

    @tbl = cardify_theme_table_generate params

    render :partial => 'cardify_theme_table' if display
  end

  def index
    cms_page_path ['Content'], 'Cardify Themes'
    
    display_cardify_theme_table(false)
  end


  def edit
    @theme = CardifyTheme.find_by_id(params[:path][0]) || CardifyTheme.new
    cms_page_path ['Content', 'Cardify Themes'], @theme.id ? 'Edit Theme' : 'Create Theme'

    if request.post? 
      if params[:commit] && @theme.update_attributes(params[:cardify_theme])
        flash[:notice] = "Theme Saved"
        redirect_to :action => 'index'
      else
        redirect_to :action => 'index'
      end
    end

  end

  
end




