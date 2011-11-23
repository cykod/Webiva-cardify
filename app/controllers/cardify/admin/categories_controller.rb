class Cardify::Admin::CategoriesController < ModuleController

  component_info 'Cardify'

  permit 'cardify_manage'

  cms_admin_paths 'content', 'Cardify Categories' => {:action => 'index'}

  active_table :cardify_category_table, CardifyCategory,
    [ :check, 
      :name, 
      :description
    ]

  def display_cardify_category_table(display=true)
    active_table_action 'cardify_category' do |act, ids|
      case act
      when 'delete'
        CardifyCategory.destroy ids
      end
    end

    @tbl = cardify_category_table_generate params, :order => 'name'

    render :partial => 'cardify_category_table' if display
  end

  def index
    cms_page_path ['Content'], 'Cardify Categories'
    
    display_cardify_category_table(false)
  end


  def edit
    @cat = CardifyCategory.find_by_id(params[:path][0]) || CardifyCategory.new
    cms_page_path ['Content', 'Cardify Categories'], @cat.id ? 'Edit Category' : 'Create Category'

    if request.post? 
      if params[:commit] && @cat.update_attributes(params[:cardify_category])
        flash[:notice] = "Category Saved"
        redirect_to :action => 'index'
      else
        redirect_to :action => 'index'
      end
    end

  end

  
end




