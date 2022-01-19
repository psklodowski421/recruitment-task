
shared_examples_for 'responds successfully with an HTTP 200 status code' do
  it 'responds successfully with an HTTP 200 status code' do
    expect(subject).to be_successful
    expect(subject).to have_http_status(200)
  end
end
