module HomeHelper

  def get_top_three(recs)
    i = 0
    j = 0
    resources = []
    until (i > 2 || j >= recs.length)
      rec = recs[j]
      unless rec.hidden
        section = rec.section
        page = section.resource_page
        class_room = page.class_room
        resources << [rec, [class_room, page, section, rec]]
        i+=1
      end
      j+=1
    end
    return resources
  end

end
