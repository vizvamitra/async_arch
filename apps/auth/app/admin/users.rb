ActiveAdmin.register Employee do
  permit_params :email, :password, :password_confirmation, :first_name,
                :last_name, :role
  actions :all, :except => [:destroy]

  index do
    selectable_column
    id_column
    column :email
    column :first_name
    column :last_name
    column(:role) { |employee| status_tag employee.role }
    column :created_at
    column :updated_at
    actions
  end

  filter :email
  filter :first_name
  filter :last_name
  filter :role
  filter :created_at

  show do
    attributes_table do
      row :id
      row :public_id
      row :email
      row(:role) { |employee| status_tag employee.role }
      row :first_name
      row :last_name
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs "Credentials" do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end

    f.inputs "Authorization" do
      f.input :role, include_blank: false, input_html: { disabled: resource.persisted? }
    end

    f.inputs "Personal Info" do
      f.input :first_name
      f.input :last_name
    end

    f.actions
  end

  controller do
    def create
      result = Employees::Create.new.call(
        **permitted_params[:employee].to_h.symbolize_keys
      )

      result
        .fmap { |employee| redirect_to admin_employee_path(employee) }
        .or do |employee|
          @employee = employee
          render :new
        end
    end
  end

end
