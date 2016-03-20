splitter = $('.split-panel').touchSplit({leftMin:300, rightMin:300, thickness: "10px", dock:"left"})
splitter.getFirst().touchSplit({thickness: "20px", orientation:"vertical"})