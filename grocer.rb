require('pry')
def consolidate_cart(cart)
  newcart={}
 cart.each{ |item| item_name=item.keys[0]
if newcart.key?(item_name)
  newcart[item_name][:count]+=1
else newcart[item_name]=item[item_name]
  newcart[item_name][:count]=1
end
}
newcart
end

def apply_coupons(cart, coupons)
  newcart={}
  newcart.merge!(cart)
  cart.each{|food,info|
    coup_count=0
    coupons.each_with_index {|coupon,index| 
      if (coupon[:item]==food && cart[food][:count] >= coupon[:num])
        newitem={"#{food} W/COUPON"=> info.dup}
        newitem["#{food} W/COUPON"][:price]=coupon[:cost]
        coup_count+=1
        newitem["#{food} W/COUPON"][:count]=coup_count
        info[:count]-=coupon[:num]
        newcart[food]=info
        newcart.merge!(newitem)
      end
    }
  }
newcart
end

def apply_clearance(cart)

cart.each{|food,info|
if info[:clearance]==true
  info[:price]=info[:price]*4/5
end
cart[food]=info
}
cart
end

def checkout(cart, coupons)
cart=consolidate_cart(cart)
cart=apply_coupons(cart,coupons) if coupons
cart=apply_clearance(cart)
total=0
cart.each{|food,info|total+=info[:price]*info[:count]}
total*=0.90 if total>100
total
end
puts checkout([
 {"BEER" => {:price => 13.00, :clearance => false}},
 {"BEER" => {:price => 13.00, :clearance => false}},
 {"BEER" => {:price => 13.00, :clearance => false}}
], [{:item => "BEER", :num => 2, :cost => 20.00},{:item => "BEER", :num => 2, :cost => 20.00}]
)