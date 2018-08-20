def consolidate_cart(cart)
  consolidated_cart = {}
  cart.each do |item|
    item.each do |item_key, item|
      item_count = count(cart, item_key)
      consolidated_cart[item_key] = {count: item_count, price: item[:price], clearance: item[:clearance]}
    end
  end 
  consolidated_cart
end

def count(cart, key)
  count = 0
  cart.each do |item|
    item.each do  |item_key, item|
     count +=1 if item_key == key
    end
  end
  count
end