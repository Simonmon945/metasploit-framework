module CredentialDataProxy

  def create_credential(opts)
    begin
      data_service = self.get_data_service
      data_service.create_credential(opts)
    rescue => e
      self.log_error(e, "Problem creating credential")
    end
  end

  def creds(opts = {})
    begin
      data_service = self.get_data_service
      add_opts_workspace(opts)
      data_service.creds(opts)
    rescue => e
      self.log_error(e, "Problem retrieving credentials")
    end
  end

  def update_credential(opts)
    begin
      data_service = self.get_data_service
      add_opts_workspace(opts)
      data_service.update_credential(opts)
    rescue => e
      self.log_error(e, "Problem updating credential")
    end
  end

  def delete_credentials(opts)
    begin
      data_service = self.get_data_service
      data_service.delete_credentials(opts)
    rescue => e
      self.log_error(e, "Problem deleting credentials")
    end
  end
end