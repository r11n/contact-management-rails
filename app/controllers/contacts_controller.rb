class ContactsController < ApplicationController
    before_action :set_group
    before_action :set_contact, only: [:show, :update, :destroy]
    def index
        @contacts = Contact.where(user_id: current_user.id, group_id: params[:group_id].to_i).paginate(page: params[:page] || 1)
        render json: @contacts
    end

    def show
        render json: @contact
    end

    
    def create
        @contact = Contact.new(contact_params)
        if @group.save
            render json: @contact, status: :created
        else
            render json: @contact.errors, status: :unprocessable_entity
        end
    end

    
    def update
        if @contact.update(contact_params)
            render json: @contact
        else
            render json: @contact.errors, status: :unprocessable_entity
        end
    end

    
    def destroy
        if @contact.destroy
            render json: {message: "deleted"}, status: :ok
        else
            render json: {message: "Cannot Delete the Contact"}, status: :unprocessable_entity
        end
    end

    private
    def contact_params
        if params[:action] == 'create'
            params[:group][:user_id] = current_user.id
            params.require(:contact).permit(:name, :user_id, :is_favorite, contact_numbers_attributes: [:id, :type, :contact_id, :number], contact_emails_attributes: [:id, :type, :contact_id, :email], contact_addresses_attributes: [:id, :type, :contact_id, :address]) 
        else
            params.require(:contact).permit(:name, :is_favorite, contact_numbers_attributes: [:id, :type, :contact_id, :number], contact_emails_attributes: [:id, :type, :contact_id, :email], contact_addresses_attributes: [:id, :type, :contact_id, :address]) 
        end
    end

    def set_group
        @group = Group.find_by(id: params[:group_id].to_i, user_id: current_user.id, status: true)
        raise ActiveRecord::RecordNotFound if !@group.present?
    end

    def set_contact
        @contact = Contact.find_by(id: params[:id].to_i,group_id: params[:group_id].to_i, user_id: current_user.id)
        raise ActiveRecord::RecordNotFound if !@contact.present?
    end
end