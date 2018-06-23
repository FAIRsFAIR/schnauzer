require 'rails_helper'

describe "Repositories", type: :request, vcr: true do
  let(:headers) { {'ACCEPT'=>'application/vnd.api+json', 'CONTENT_TYPE'=>'application/vnd.api+json' } }

  describe 'GET /repositories' do
    context 'filter by subject' do
      it 'returns repositories' do
        get '/repositories?subject=34', nil, headers: headers

        expect(json['data'].size).to eq(25)
        expect(json.dig('meta', 'total')).to eq(2053)

        response = json['data'].first
        expect(response.dig('attributes', 'created')).to eq("2016-11-10T15:51:32Z")
        expect(response.dig('attributes', 'repository-name')).to eq("Global Change Research Data Publishing and Repository")
        expect(response.dig('attributes', 'subjects').size).to eq(6)
        expect(response.dig('attributes', 'subjects').last).to eq("text"=>"34 Geosciences (including Geography)", "scheme"=>"DFG")
        expect(last_response.status).to eq(200)
      end
    end

    context 'filter by query' do
      it 'returns repositories' do
        get '/repositories?subject=34&query=climate', nil, headers: headers

        expect(json['data'].size).to eq(25)
        expect(json.dig('meta', 'total')).to eq(246)

        response = json['data'].first
        expect(response.dig('attributes', 'created')).to eq("2014-09-25T09:39:17Z")
        expect(response.dig('attributes', 'repository-name')).to eq("Environment Climate Data Sweden")
        expect(last_response.status).to eq(200)
      end
    end

    context 'filter open access' do
      it 'returns repositories' do
        get '/repositories?subject=34&query=climate&open=true', nil, headers: headers

        expect(json['data'].size).to eq(25)
        expect(json.dig('meta', 'total')).to eq(246)

        response = json['data'].first
        expect(response.dig('attributes', 'created')).to eq("2014-09-25T09:39:17Z")
        expect(response.dig('attributes', 'repository-name')).to eq("Environment Climate Data Sweden")
        expect(response.dig('attributes', 'data-accesses').first).to eq("restrictions"=>[], "type"=>"open")
        expect(last_response.status).to eq(200)
      end
    end

    context 'filter certified' do
      it 'returns repositories' do
        get '/repositories?subject=34&query=climate&certified=true', nil, headers: headers

        expect(json['data'].size).to eq(25)
        expect(json.dig('meta', 'total')).to eq(246)

        response = json['data'].first
        expect(response.dig('attributes', 'created')).to eq("2014-09-25T09:39:17Z")
        expect(response.dig('attributes', 'repository-name')).to eq("Environment Climate Data Sweden")
        expect(response.dig('attributes', 'certificates').first).to eq("text"=>"WDS")
        expect(last_response.status).to eq(200)
      end
    end

    context 'filter pid' do
      it 'returns repositories' do
        get '/repositories?subject=34&query=climate&pid=true', nil, headers: headers

        expect(json['data'].size).to eq(25)
        expect(json.dig('meta', 'total')).to eq(246)

        response = json['data'].first
        expect(response.dig('attributes', 'created')).to eq("2014-09-25T09:39:17Z")
        expect(response.dig('attributes', 'repository-name')).to eq("Environment Climate Data Sweden")
        expect(response.dig('attributes', 'pid-systems').first).to eq("text"=>"DOI")
        expect(last_response.status).to eq(200)
      end
    end

    context 'filter disciplinary' do
      it 'returns repositories' do
        get '/repositories?subject=34&query=climate&disciplinary=true', nil, headers: headers

        expect(json['data'].size).to eq(25)
        expect(json.dig('meta', 'total')).to eq(246)

        response = json['data'].first
        expect(response.dig('attributes', 'created')).to eq("2014-09-25T09:39:17Z")
        expect(response.dig('attributes', 'repository-name')).to eq("Environment Climate Data Sweden")
        expect(response.dig('attributes', 'pid-systems').first).to eq("text"=>"DOI")
        expect(last_response.status).to eq(200)
      end
    end

    context 'sort by created' do
      it 'returns repositories' do
        get '/repositories?sort=created', nil, headers: headers

        expect(json['data'].size).to eq(25)
        response = json['data'].first
        expect(response.dig('attributes', 'created')).to eq("2014-03-31T09:39:16Z")
        expect(response.dig('attributes', 'repository-name')).to eq("UniProtKB/Swiss-Prot")
        expect(last_response.status).to eq(200)
      end
    end

    context 'sort by created desc' do
      it 'returns repositories' do
        get '/repositories?sort=-created', nil, headers: headers

        expect(json['data'].size).to eq(25)
        response = json['data'].first
        expect(response.dig('attributes', 'created')).to eq("2016-01-27T11:59:56Z")
        expect(last_response.status).to eq(200)
      end
    end

    context 'sort by name' do
      it 'returns repositories' do
        get '/repositories?sort=name', nil, headers: headers

        expect(json['data'].size).to eq(25)
        response = json['data'].first
        expect(response.dig('attributes', 'created')).to eq("2013-08-07T09:39:16Z")
        expect(response.dig('attributes', 'repository-name')).to eq("'Health Monitoring' Research Data Centre at the Robert Koch Institute")
        expect(last_response.status).to eq(200)
      end
    end

    context 'sort by name desc' do
      it 'returns repositories' do
        get '/repositories?sort=-name', nil, headers: headers

        expect(json['data'].size).to eq(25)
        response = json['data'].first
        expect(response.dig('attributes', 'created')).to eq("2015-04-07T09:39:18Z")
        expect(response.dig('attributes', 'repository-name')).to eq("ZVDD")
        expect(last_response.status).to eq(200)
      end
    end

    context 'sort default' do
      it 'returns repositories' do
        get '/repositories', nil, headers: headers

        expect(json['data'].size).to eq(25)
        response = json['data'].first
        expect(response.dig('attributes', 'created')).to eq("2014-03-31T09:39:16Z")
        expect(response.dig('attributes', 'repository-name')).to eq("UniProtKB/Swiss-Prot")
        expect(last_response.status).to eq(200)
      end
    end

    context 'page[size]=2' do
      it 'returns repositories' do
        get '/repositories?page[size]=2', nil, headers: headers

        expect(json['data'].size).to eq(2)
        expect(last_response.status).to eq(200)
      end
    end

    context 'page[size]=20' do
      it 'returns repositories' do
        get '/repositories?page[size]=100', nil, headers: headers

        expect(json['data'].size).to eq(100)
        expect(last_response.status).to eq(200)
      end
    end

    context 'page[size]=2 and page[number]=2' do
      it 'returns repositories' do
        get '/repositories?page[size]=2&page[number]=2', nil, headers: headers

        expect(json['data'].size).to eq(2)
        expect(last_response.status).to eq(200)
      end
    end
  end

  describe 'GET /repositories/:id' do
    context 'when the record exists' do
      it 'returns the repository' do
        get "/repositories/100010677", nil, headers

        expect(last_response.status).to eq(200)
        expect(json.dig('data', 'id')).to eq("100010677")
        expect(json.dig('data', 'attributes', 'repository-name')).to eq("UniProtKB/Swiss-Prot")
      end
    end

    context 'when the record does not exist' do
      it 'returns a not found message' do
        get "/repositories/xxx", nil, headers

        expect(last_response.status).to eq(404)
        expect(json["errors"].first).to eq("status"=>"404", "title"=>"The resource you are looking for doesn't exist.")
      end
    end
  end
end
