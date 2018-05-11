class RepositorySerializer < ActiveModel::Serializer
  attributes :repositoryName, :repositoryUrl, :repositoryContacts, :description, :certificates, :types, 
    :additionalNames, :subjects, :contentTypes, :providerTypes, 
    :keywords, :institutions, :dataAccesses, :dataUploads, :dataUploadLicenses, :pidSystems,
    :apis, :pidSystems, :startDate, :endDate, :created, :updated

  def id
    object.identifier["re3data"]
  end

  def subjects
    object.subjects.sort_by { |subject| subject["text"] }
  end

  def created
    object.created.strftime("%FT%TZ")
  end

  def updated
    object.updated.strftime("%FT%TZ")
  end
end