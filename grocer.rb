require 'pry'
# Create a checkout method to calculate the total cost of a cart of items and apply discounts and coupons as necessary.

cart = [
   {"AVOCADO" => {:price => 3.00, :clearance => true}},
   {"KALE" => {:price => 3.00, :clearance => false}},
   {"BLACK_BEANS" => {:price => 2.50, :clearance => false}},
   {"ALMONDS" => {:price => 9.00, :clearance => false}},
   {"TEMPEH" => {:price => 3.00, :clearance => true}},
   {"CHEESE" => {:price => 6.50, :clearance => false}},
   {"BEER" => {:price => 13.00, :clearance => false}},
   {"PEANUTBUTTER" => {:price => 3.00, :clearance => true}},
   {"BEETS" => {:price => 2.50, :clearance => false}},
   {"SOY MILK" => {:price => 4.50, :clearance => true}}
]

coupons = [
   {:item => "AVOCADO", :num => 2, :cost => 5.00},
   {:item => "BEER", :num => 2, :cost => 20.00},
   {:item => "CHEESE", :num => 3, :cost => 15.00}
]


# The cart starts as an array of individual items.
# Translate it into a hash that includes the counts for each item with the consolidate_cart method.

def consolidate_cart(cart)
  result = {}
  cart.each do |items| # [{"AVOCADO" =>{..}]
    items.each do |item, data|
      count = cart.count(items) #count = counting each item in cart
      data[:count] = count #create key :count that will keep track of number of items
      result[item] ||= {} # true if key has value, else value is empty {}
      result[item] = data #put it all together
    end
  end
 result
end

# apply coupon to the cart,
# adds a new key, value pair to the cart hash called 'ITEM NAME W/COUPON'
# adds the coupon price to the property hash of couponed item
# adds the count number to the property hash of couponed item
# removes the number of discounted items from the original item's count
# remembers if the item was on clearance
# accounts for when there are more items than the coupon allows
# doesn't break if the coupon doesn't apply to any items

def apply_coupons(cart, coupons)
  cart = cart.dup
  coupons.each do |coupon|
    item = coupon[:item]
  #cart[item]=if item in cart matches coupon item
    if cart[item] && (cart[item][:count] >=coupon[:num])#amount in cart >= coupon limit
      cart[item][:count] -= coupon[:num] #remove discount items from cart
      unless cart["#{item} W/COUPON"] # create a coupon if none exists, this {}:
        cart["#{item} W/COUPON"] = {:price => coupon[:cost],
                                      :clearance => cart[item][:clearance],
                                      :count => 1}
      else
        cart["#{item} W/COUPON"][:count] += 1 #increase :count if num items > coupon limit
      end
    end
  end
  cart
end



# apply clearance:
# takes 20% off price if the item is on clearance
# does not discount the price for items not on clearance


def apply_clearance(cart)
  cart = cart.dup
  cart.each do |item, data|
      # if clearance is true = take 20% off; no discount = return cart
    data[:clearance] ? data[:price] = (data[:price]*0.8).round(2) : cart
  end
end


#{}`checkout` method that calculates the total cost of the consolidated cart.
#When checking out, follow these steps *in order*:
#* Apply coupon discounts if the proper number of items are present.
#* Apply 20% discount if items are on clearance.
#* If, after applying the coupon discounts and the clearance discounts, the cart's total is over $100, then apply a 10% discount.

def checkout(cart, coupons)
    #call methods and track discounts
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart, coupons)
  cart = apply_clearance(cart)

  total = 0
  cart.each { |item, data| total += (data[:price] * data[:count]).to_f }
  total > 100 ? (total *= 0.9).round(2) : total
end
