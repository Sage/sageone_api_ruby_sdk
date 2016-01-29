require 'spec_helper'

describe SageoneSdk::Client::Products do
  before :each do
    SageoneSdk.reset!
  end

  let(:client) { SageoneSdk::Client.new({access_token: "foo", signing_secret: "bar" }) }

  describe "products", :vcr do
    it "returns all products" do
      products = client.products
      expect(products.first.product_code).not_to be_nil
    end

    it "allows pagination" do
      products = client.products({ "$itemsPerPage" => 2 })
      expect(products.count).to eq(2)
    end
  end

  describe "products/:id", :vcr do
    before :each do
      VCR.use_cassette('products_index') do
        @product_id = client.products.first.id
      end
    end

    it "returns a specific product" do
      product = client.product(@product_id)
      expect(product.description).to eq("Foo")
    end
  end

  describe "create products", :vcr do
    it "creates a new product" do
      product = client.create_product(:description => "Foo")
      expect(product.description).to eq("Foo")
    end

    context "on error" do
      it "responds with an appropriate error message" do
        product = client.create_product({})
        expect(product.error?).to eq(true)
        expect(product.full_messages).to include("Description: blank")
      end
    end
  end

  describe "update a product", :vcr do
    before :each do
      VCR.use_cassette('products_index') do
        @product_id = client.products.first.id
      end
    end

    it "updates the given product" do
      product = client.update_product(@product_id, { :product_code => "Bar" })
      expect(product.product_code).to eq("Bar")
    end
  end

  describe "delete a product", :vcr do
    before :each do
      VCR.use_cassette('product_create') do
        @product_id = client.create_product(:description => "Foo").id
      end
    end

    it "deletes the product" do
      product = client.delete_product(@product_id)
      expect(product).to_not be_nil
    end
  end
end
