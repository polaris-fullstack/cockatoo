module Madmin
  class PlansController < Madmin::ResourceController
    private

    # Add support for features array
    def resource_params
      params.require(resource.param_key)
        .permit(*resource.permitted_params, features: [])
        .with_defaults(features: [])
        .transform_values { |v| change_polymorphic(v) }
    end
  end
end
