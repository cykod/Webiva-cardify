
class Cardify::AdminController < ModuleController

  component_info 'Cardify', :description => 'Cardify support', 
                              :access => :public
                              
  # Register a handler feature
  register_permission_category :cardify, "Cardify" ,"Permissions related to Cardify"
  
  register_permissions :cardify, [ [ :manage, 'Manage Cardify', 'Manage Cardify' ],
                                  [ :config, 'Configure Cardify', 'Configure Cardify' ]
                                  ]

  content_model :cardify
  
  cms_admin_paths "options",
     "Cardify Options" => { :action => 'index' },
     "Options" => { :controller => '/options' },
     "Modules" => { :controller => '/modules' }

  permit 'cardify_config'

  public 

  def self.get_cardify_info
    [{ :name => 'Cardify Categories', :url => { :controller => '/cardify/admin/categories', :action => 'index' }, 
       :permission => :cardify_manage },
     { :name => 'Cardify Icons', :url => { :controller => '/cardify/admin/icons', :action => 'index' }, 
       :permission => :cardify_manage },
     { :name => 'Cardify Themes', :url => { :controller => '/cardify/admin/themes', :action => 'index' }, 
       :permission => :cardify_manage },
     { :name => 'Cardify Photos', :url => { :controller => '/cardify/admin/photos', :action => 'index' }, 
       :permission => :cardify_manage }
    ]
  end

 
  def options
    cms_page_path ['Options','Modules'],"Cardify Options"
    
    @options = self.class.module_options(params[:options])
    
    if request.post? && @options.valid?
      Configuration.set_config_model(@options)
      flash[:notice] = "Updated Cardify module options".t 
      redirect_to :controller => '/modules'
      return
    end    
  
  end
  
  def self.module_options(vals=nil)
    Configuration.get_config_model(Options,vals)
  end
  
  class Options < HashModel
   # Options attributes 
   # attributes :attribute_name => value
  
  end

end
