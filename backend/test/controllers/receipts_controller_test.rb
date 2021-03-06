require 'test_helper'

class ReceiptsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @receipt = receipts(:one)
  end

  test "should get index" do
    get receipts_url, as: :json
    assert_response :success
  end

  test "should create receipt" do
    assert_difference('Receipt.count') do
      post receipts_url, params: { receipt: { category: @receipt.category, editor_id: @receipt.editor_id, name: @receipt.name, owner: @receipt.owner, purchased_at: @receipt.purchased_at, shop_id: @receipt.shop_id } }, as: :json
    end

    assert_response 201
  end

  test "should show receipt" do
    get receipt_url(@receipt), as: :json
    assert_response :success
  end

  test "should update receipt" do
    patch receipt_url(@receipt), params: { receipt: { category: @receipt.category, editor_id: @receipt.editor_id, name: @receipt.name, owner: @receipt.owner, purchased_at: @receipt.purchased_at, shop_id: @receipt.shop_id } }, as: :json
    assert_response 200
  end

  test "should destroy receipt" do
    assert_difference('Receipt.count', -1) do
      delete receipt_url(@receipt), as: :json
    end

    assert_response 204
  end
end
