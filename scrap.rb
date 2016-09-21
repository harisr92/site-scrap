require 'mechanize'

USER_AGENT = 'Mac Safari'

def getPage(url,agent)
  page = agent.get(url)
  page.form('form1')
end

def getList(select,form)
  form.field_with(:name => select).options
end

agent = Mechanize.new
agent.user_agent_alias = USER_AGENT
agent.follow_meta_refresh=true
page = getPage('http://210.212.18.115:8880/default2.aspx',agent)
list1 =  getList('DropDownList1',page)
length_list1 = list1.size - 1
(0..length_list1).each do |i|
  list1[i].click
  page = agent.submit(page)	
  form = page.form('form1')
  option2 = getList('DropDownList2',form)
  length_options = option2.size - 1
  (0..length_options).each do |j|
    option2[j].click
    pdf = agent.submit(form)
    pdf.save
    page = getPage('http://210.212.18.115:8880/default2.aspx',agent)
    list1 = getList('DropDownList1',page)
  end
end

