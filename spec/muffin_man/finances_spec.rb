RSpec.describe MuffinMan::Finances::V0 do
  before do
    stub_request_access_token
    stub_list_financial_event_groups
  end

  let(:max_results_per_page) { 10 }
  let(:financial_event_group_started_before) { Time.now - 3600 }
  let(:financial_event_group_started_after) { Time.now  }

  subject(:finances_client) { described_class.new(credentials) }

  describe "list_financial_event_groups" do
    it 'makes a get request to list financial event groups' do
      expect(finances_client.list_financial_event_groups(max_results_per_page, financial_event_group_started_before, financial_event_group_started_after).response_code).to eq(200)
    end
  end
end
