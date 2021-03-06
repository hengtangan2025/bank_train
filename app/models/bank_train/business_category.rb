module BankTrain
  class BusinessCategory
    include Mongoid::Document
    include Mongoid::Timestamps

    field :name

    has_and_belongs_to_many :posts, class_name: 'BankTrain::Post'
    has_and_belongs_to_many :business_operations, class_name: 'BankTrain::BusinessOperation' 

    belongs_to :parent_category, class_name: 'BankTrain::BusinessCategory' 
    has_many :children_categories, class_name: 'BankTrain::BusinessCategory'

    module UserMethods
      extend ActiveSupport::Concern

      # 获取当前用户能够操作的业务类型
      def train_business_categories
        train_posts.map {|post|
          post.business_categories
        }.flatten.uniq
      end
    end
  end
end