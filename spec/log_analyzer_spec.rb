RSpec.describe LogAnalyzer do
  it "has a version number" do
    expect(LogAnalyzer::VERSION).not_to be nil
  end

  describe '.run' do
    subject(:result) { LogAnalyzer.run(fpath) }
    let(:fpath) { File.expand_path('./', File.join('spec', 'data', fname)) }

    context 'with no log entries' do
      let(:fname) { 'empty.log' }
      it 'returns empty results' do
        expect(result[:total_views]).to be_empty
        expect(result[:unique_views]).to be_empty
      end
    end
    
    context 'with malformed log entries' do
      let(:fname) { 'malformed.log' }
      it 'raises an error' do
        expect { result }.to raise_error(LogAnalyzer::Error)
      end
    end

    context 'with valid logfile' do
      context 'when no distinct entries' do
        let(:fname) { 'no_distinct.log' }
        it 'returns results equal to no of log entries' do
          is_expected.not_to be_empty
          expected = [['/page2', 1], ['/page1', 1]]
          expect(result[:total_views]).to eq(expected)
          expect(result[:unique_views]).to eq(expected)
        end
      end
      context 'with duplicate entries but no unique views' do
        let(:fname) { 'no_unique.log' }
        it 'groups duplicate entries for most_views' do
          is_expected.not_to be_empty
          expect(result[:total_views]).to eq([['/page1', 2], ['/page2', 1]])
          expect(result[:unique_views]).to eq([['/page1', 1], ['/page2', 1]])
        end
      end
      context 'with duplicate entries and unique views' do
        let(:fname) { 'unique.log' }
        it 'groups unique views and sorts by count' do
          is_expected.not_to be_empty
          expect(result[:total_views]).to eq([['/page1', 3], ['/page2', 2]])
          expect(result[:unique_views]).to eq([['/page2', 2], ['/page1', 1]])
        end
      end
    end
  end
end
