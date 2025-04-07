function enqueue(tbl, value)
    tbl[#tbl + 1] = value
end

-- Dequeue (remove from front)
function dequeue(tbl)
    if #tbl == 0 then return nil end

    local value = tbl[1]

    -- shift all elements left
    for i = 1, #tbl - 1 do
        tbl[i] = tbl[i + 1]
    end

    tbl[#tbl] = nil -- remove last element

    return value
end