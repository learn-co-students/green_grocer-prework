
def checkout(cart, coupons)
  # code here
  total = 0.00
  # puts cart
  # coupons.nil?  ? (puts "No coupon")  : (puts "coupons::#{coupons}")
  # puts "#{*arguments.count}"
  cart = consolidate_cart(cart)
  cart = apply_coupons(cart,coupons)
  cart = apply_clearance(cart)
  cart.each do |item, item_values|
    total += ( item_values[:price] * item_values[:count])
  end
  # puts "***********************#{cart}"
  total = (total * 0.9).round(2) if total > 100
  total
end




def apply_clearance(cart)
  # code here
  # cart.each do |item|
  cart.each do |item,value|
    if value[:clearance] == true
      value[:price] = (value[:price] * (0.8)).round(2)
    end #if
  end #each
end




def apply_coupons(cart, coupons)
  # code here
  coupons.each do |coupon|
    # puts "#{coupon}"
    item_name = coupon[:item]                                         #avacado
    # puts item_name
    new_item_name =   coupon[:item].to_s + " W/COUPON"                #avacado /w coupon
    if cart[item_name].nil?   #coupon doesnt apply to any items
      #do nothing
    elsif cart[item_name][:count] >= coupon[:num]           #only apply coupon if there are enough items to apply coupon to

      if  !cart[new_item_name].nil?# if # a duplicate coupon in system, this is a duplicate coupon
        cart[new_item_name][:count] += 1 #if !cart[new_item_name][:count].nil?   #incremets count of 1 if 2nd coupon
        cart[item_name][:count] -= coupon[:num] #remove number  from non couponed item

      elsif cart[coupon[:item]]   #if the item exists but new coupon
        # puts "#{cart[coupon[:item]]}"
        #generate a new item "item name w/coupon" in cart
        #might want to add / check for double coupons in future

        # puts new_item_name
        # do we want to check to see if there is more coupon than item?
        cart[new_item_name] = {}
        cart[new_item_name][:price] = coupon[:cost]
        cart[new_item_name][:clearance] = cart[item_name][:clearance]
        cart[new_item_name][:count] = 1 if cart[new_item_name][:count].nil?   #creates count of 1 if first coupon
        cart[item_name][:count] -= coupon[:num]

        # puts "#{cart}"
      end #cart[coupon[item]]

    end  #cart[item_name][:count] >= coupon[:num]
  end #each coupon
  cart
end



# The cart starts as an array of individual items. Translate it into a hash that includes the counts for each item with the consolidate_cart method.
def consolidate_cart(cart)
  consolidated = {}
  cart.each do |single_item|
    # puts "#{single_item}"
    single_item.each do |item_name, item_values|
      # puts "#{item_name}::#{item_values}"
      if consolidated[item_name].nil?
        consolidated[item_name] = item_values
        consolidated[item_name][:count] = 1
      else
        consolidated[item_name][:count] += 1
      end #if consolidated
    end #item_name
  end
  consolidated
end
