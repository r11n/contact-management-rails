class ContactsController < ApplicationController
    before_action :set_group
    before_action :set_contact, only: [:show, :update, :destroy, :delete_attribute]
    def index
        @contacts = Contact.where(user_id: current_user.id, group_id: params[:group_id].to_i).order(:name).paginate(page: params[:page] || 1)
        render json: {contacts: @contacts, count: Contact.where(user_id: current_user.id, group_id: params[:group_id].to_i).count}
    end

    def show
        @contact = Contact.includes(:contact_numbers, :contact_emails, :contact_addresses).find(@contact.id)
        render json: @contact, include: [:contact_numbers, :contact_emails, :contact_addresses]
    end

    
    def create
        @contact = Contact.new(contact_params)
        if @contact.save
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

    def delete_attribute
        begin
            cls = Object.const_get('Contact' + params[:attr_type].to_s.capitalize)
            obj = cls.find_by(id: params[:attr_id], contact_id: @contact.id)
            if obj.present?
                obj.destroy
                render json: {message: 'success'}, status: :ok
            else
                raise ActiveRecord::RecordNotFound
            end
        rescue => error
            raise ActiveRecord::RecordNotFound
        end
    end

    private
    def contact_params
        if params[:action] == 'create'
            params[:contact][:user_id] = current_user.id
            params.require(:contact).permit(
                :name,
                :user_id,
                :group_id,
                :is_favorite,
                contact_numbers_attributes: [:id, :contact_type, :contact_id, :number],
                contact_emails_attributes: [:id, :contact_type, :contact_id, :email],
                contact_addresses_attributes: [:id, :contact_type, :contact_id, :address]) 
        else
            params.require(:contact).permit(
                :name,
                :is_favorite,
                contact_numbers_attributes: [:id, :contact_type, :contact_id, :number],
                contact_emails_attributes: [:id, :contact_type, :contact_id, :email],
                contact_addresses_attributes: [:id, :contact_type, :contact_id, :address]) 
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