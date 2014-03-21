require 'peek'

Peek.into Peek::Views::Dalli
Peek.into Peek::Views::Git, :nwo => 'noted/noted'
Peek.into Peek::Views::GC
Peek.into Peek::Views::Moped
Peek.into Peek::Views::PerformanceBar
Peek.into Peek::Views::Rblineprof
