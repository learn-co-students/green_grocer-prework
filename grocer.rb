require 'pry'
def consolidate_cart(cart)
  # code here
  cart.each_with_object({}) do |items_hash, result_hash| # |{"TEMPEH"=>{:price=>3.0, :clearance=>true}}, {}|
    items_hash.each do |item_name, details_hash| # |"TEMPEH", {:price=>3.0, :clearance=>true}|
      if result_hash[item_name] # checks if item_name exists in the result_hash
        details_hash[:count] += 1 #if it does exist, increase the value of :count by 1
      else # if the item_name doesn't exist in the result_hash then create
        details_hash[:count] = 1
        result_hash[item_name] = details_hash
      end
    end
  end
end

def apply_coupons(cart, coupons)
  # code here
  # cart = {"AVOCADO"=>{:price=>3.0, :clearance=>true, :count=>2}}
  coupons.each do |coupon_hash| # |{:item=>"AVOCADO", :num=>2, :cost=>5.0}|
    item_name = coupon_hash[:item]
    if cart[item_name] && (cart[item_name][:count] >= coupon_hash[:num]) # if "AVOCADO" is in the cart & it's count is >= to the coupon num
      if cart["#{item_name} W/COUPON"] # if "AVOCADO W/COUPON" is true execute block
        cart["#{item_name} W/COUPON"][:count] += 1
      else # if "AVOCADO W/COUPON" isn't true then create it inside the cart
        cart["#{item_name} W/COUPON"] = {:price => coupon_hash[:cost], :count => 1}
        cart["#{item_name} W/COUPON"][:clearance] = cart[item_name][:clearance]
      end
      cart[item_name][:count] -= coupon_hash[:num] # reduces "AVOCADO" count by the coupon num
    end
  end
  cart
end

def apply_clearance(cart)
  # code here #cart = {"TEMPEH"=>{:price=>3.0, :clearance=>true, :count=>1}}
  cart.each do |item_name, details_hash| # |"TEMPEH", {:price=>3.0, :clearance=>true, :count=>1}
    if details_hash[:clearance] == true
      updated_price = details_hash[:price] * 0.8 #this produces 2.40000000004
      details_hash[:price] = updated_price.round(2) # assigns the rounded product 2.4 to the :price
    end
  end
end

def checkout(cart, coupons)
  # code here
  combined_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(combined_cart, coupons)
  clearanced_cart = apply_clearance(couponed_cart)
  cart_total = 0
  clearanced_cart.each do |item, details_hash| # |"BEETS", {:price=>2.5, :clearance=>false, :count=>1}|
    cart_total += (details_hash[:price] * details_hash[:count])
  end
  if cart_total > 100 # apply 10% discount if cart total > 100
    cart_total *= 0.9
  else
    cart_total
  end
end
