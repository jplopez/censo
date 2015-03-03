Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  # Api
  scope '/api' do
    # Version 1
    scope '/v1' do

      # Units
      scope '/units' do
        get '/' => 'api_units#index' # all units
        post '/' => 'api_units#create' # create unit
        # Unit by key
        scope '/:key' do
          get '/' => 'api_units#show' # show unit
          put '/' => 'api_units#update' # update unit
          delete '/' => 'api_units#delete' # delete unit
          # People in Unit
          scope '/people' do
            get '/' => 'api_people#index'
            post '/' => 'api_people#create'
            # People By Id
            scope '/:people_id' do
              get '/' => 'api_people#show'
              put '/' => 'api_people#update'
              delete '/' => 'api_people#delete'
            end

          end
        end
      end
    end
  end

end
