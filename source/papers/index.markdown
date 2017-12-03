---
layout: page
title: "Published and Unpublished Papers"
date: 2017-11-12 15:39
comments:
sharing:
footer: false
---

**Embracing Explicit Communication in Work-Stealing Runtime Systems**  
<font size="3">
Doctoral Thesis, University of Bayreuth, 2016 |
<a title="PDF" class="falink" href="/papers/thesis.pdf"><i class="fa fa-file-pdf-o"/></i></a>  
Slides: <a title="PDF" class="falink" href="/papers/thesis_slides.pdf"><i class="fa fa-file-pdf-o"/></i></a>

> Parallel computers are commonplace. The trend of increasing the number of
> processor cores highlights the importance of parallel computing: a
> single-threaded program uses a fraction of a modern processor’s resources
> and potential, and that fraction will only decrease over the coming
> processor generations. Existing abstractions for writing parallel programs,
> such as threads and mutual exclusion locks, are difficult to understand,
> use, and reason about, making them a poor choice for mainstream parallel
> programming. Higher-level abstractions aim to achieve a more favorable
> division of labor between programmers and compilers/runtime systems, with
> programmers expressing and exposing parallelism and compilers/runtime
> systems managing parallel execution. A popular and effective abstraction is
> that of a task, a piece of work, usually a function or a closure, that is
> safe to execute in parallel with other tasks. Scheduling decisions,
> including the mapping of tasks to threads, are made by the runtime system
> and are not imposed on the programmer. Tasks are well-suited to express
> fine-grained parallelism, but whether fine-grained parallelism brings
> performance gains depends on the runtime system and its implementation.
> State-of-the-art runtime systems employ the scheduling and load balancing
> technique of work stealing, which is known to be efficient, both in theory
> and practice. In work stealing, idle workers, called thieves, request tasks
> from busy workers, called victims, thereby balancing the load. Most
> implementations of work stealing take advantage of shared memory by letting
> thieves “steal” tasks from the double-ended queues (deques) of their
> victims. Modern multiprocessors feature increasingly complex architectures
> that make it challenging to implement efficient yet flexible work-stealing
> schedulers. Future manycore processors may have limited support for shared
> memory, or may rely on message passing for scalable inter-core
> communication, such as Intel’s SCC research processor, a recent example of a
> “cluster-on-a-chip”. This thesis aims to put work stealing based on message
> passing on a better, more practical foundation, developing techniques to
> rival the performance of concurrent deque-based implementations, while
> remaining more flexible. Work stealing based on message passing has been
> studied before, notably in the context of distributed systems, where MPI
> still dominates. We present a work-stealing scheduler in which workers
> communicate with each other through channels, a lightweight message passing
> abstraction that goes back to Hoare’s Communicating Sequential Processes
> (CSP). Channels feature prominently in modern programming languages such as
> Go and Rust, which advocate messages to communicate, synchronize, and share
> state between threads. The advantage of using channels, as opposed to using
> low-level synchronization primitives, is that channels decouple the
> scheduler from processor-specific features, thereby increasing its
> flexibility. Large parts of this thesis are dedicated to making
> channel-based work stealing perform well on modern shared-memory
> multiprocessors. We describe an implementation in which workers exchange
> asynchronous steal requests and tasks by passing messages over channels.
> Termination is detected as a consequence of forwarding steal requests
> instead of requiring additional control messages to be passed between
> workers. Dependencies between tasks, most importantly, between parent and
> child tasks, are expressed with futures, which can be implemented
> efficiently in terms of channels. Private task queues are more flexible than
> concurrent ones. We show a simple extension that provides support for
> adaptive stealing---the ability to switch the stealing strategy at runtime.
> Fine-grained parallelism requires not only efficient work stealing, but also
> granularity control to overcome the overhead of task creation and
> scheduling. Similar tasks, such as iterations of a parallel loop, can be
> combined into a single task ready to split whenever parallelism is needed.
> We extend previous work on lazy splitting, integrate it with channel-based
> work stealing, and demonstrate performance comparable to dedicated loop
> schedulers in OpenMP. Finally, we provide experimental evidence that
> channel-based work stealing performs on par with runtime systems based on
> concurrent deques.
</font>

**Channel-based Work Stealing**  
<font size="3">
with Thomas Rauber, 2014 |
<a title="PDF" class="falink" href="/papers/channel_ws_2014.pdf"><i class="fa fa-file-pdf-o"/></i></a>

> Tasks have become a useful abstraction in parallel programming; one that
> relies on runtime systems to provide efficient task scheduling and load
> balancing. The scheduling strategy of choice is work stealing, in which idle
> workers try to take some work from busy workers. Current work-stealing
> schedulers are dependent on shared state in the form of concurrent task
> queues, most often deques, while other implementations of work stealing
> based on message passing have largely been geared towards distributed
> environments. This paper explores an alternative message-passing approach to
> work stealing that is centered around communication over channels,
> concurrent building blocks dating back to the idea of Communicating
> Sequential Processes. We propose a new scheduler, in which worker threads
> operate on private deques and communicate with each other by sending steal
> requests and tasks over channels; no shared state is assumed internally.
> Our benchmark results on a 48-core multiprocessor and a 60-core Intel Xeon
> Phi show that there is no significant slowdown due to channel communication:
> on average, the channel-based scheduler is only a few percent slower than a
> scheduler based on concurrent deques.
</font>

**Go's Concurrency Constructs on the SCC**  
<font size="3">
with Thomas Rauber, 6th MARC Symposium, 2012 |
<a title="URL" class="falink" href="http://hal.archives-ouvertes.fr/hal-00718924"><i class="fa fa-external-link"/></i></a>  

> We present an implementation of goroutines and channels on the SCC.
> Goroutines and channels are the building blocks for writing concurrent
> programs in the Go programming language. Both Go and the SCC share the same
> basic idea---the use of messages for communication and synchronization. Our
> implementation of goroutines on top of tasks reuses existing runtime support
> for scheduling and load balancing. Channels, which permit goroutines to
> communicate by sending and receiving messages, can be implemented
> efficiently using the on-die message passing buffers. We demonstrate the use
> of goroutines and channels with a parallel genetic algorithm that can
> utilize all cores of the SCC.
</font>

**A Runtime Implementation of Go's Concurrency Constructs on the Single-Chip Cloud Computer**  
<font size="3">
2011 |
<a title="PDF" class="falink" href="/papers/scc_go_2011.pdf"><i class="fa fa-file-pdf-o"/></i></a>

> Go is a general-purpose programming language intended for systems
> programming [1]. We don’t provide a general description of Go, but instead
> we focus on its support for concurrent programming, which is not the usual
> “threads and locks”, even if threads and locks are still used under the
> covers. Programmers are encouraged to “not communicate by sharing memory”
> but “to share memory by communicating.” This style of programming is
> reminiscent of message passing, where messages are used to exchange data
> between concurrently executing processes and to coordinate execution.
> Instead of using locks to guard access to shared data, programmers are
> encouraged to pass around references and thereby transfer ownership so that
> only one thread is allowed to access the data at any one time. Go’s way of
> thinking can be found elsewhere: in programming Intel’s Single-Chip Cloud
> Computer (SCC) research processor. The SCC is intended to foster manycore
> software research, on a platform that’s more like a “cluster-on-a-chip” than
> a traditional shared-memory chip multiprocessor. As such, the SCC is tuned
> for message passing rather than for “threads and locks”. Or as Jim Held
> commented on the lack of atomic operations: “In SCC we imagined messaging
> instead of shared memory or shared memory access coordinated by messages.
> [...] Use a message to synchronize, not a memory location.” [2, 3] So, we
> ask the question, isn’t Go’s concurrency model a perfect fit for such a
> processor architecture? To find out, we start by implementing the necessary
> runtime support on the SCC.
</font>

**Task Parallel Programming Support for the Single-Chip Cloud Computer**  
<font size="3">
with Thomas Rauber, 2011 |
<a title="PDF" class="falink" href="/papers/scc_tasks_2011.pdf"><i class="fa fa-file-pdf-o"/></i></a>  
Poster version (LCPC 2011):
<a title="PDF" class="falink" href="/papers/LCPC11_poster.pdf"><i class="fa fa-file-pdf-o"/></i></a>

> Task parallel programming has become a popular and effective approach for
> programming multicore systems. Tasks execute on top of threads, which are no
> longer exposed but demoted to an implementation detail. This higher level of
> abstraction makes it easier to identify opportunities for parallelism and
> leave everything else to the compiler and runtime system. An interesting
> question is always how to support the task abstraction on a new
> architecture, and, what is even more important, how to arrive at an
> efficient implementation. In this paper, we look at Intel’s Single-Chip
> Cloud Computer (SCC) and describe the design and implementation of a tasking
> environment for the SCC. We focus on the runtime system and compare two
> different implementations with work-sharing and work-stealing schedulers
> that take advantage of the processor’s on-chip memory in order to achieve
> scalable performance.
</font>

**Task Parallelism on the SCC**  
<font size="3">
with Thomas Rauber, 3rd MARC Symposium, 2011 |
<a title="URL" class="falink" href="https://publikationen.bibliothek.kit.edu/1000023937"><i class="fa fa-external-link"/></i></a>  
Poster version:
<a title="PDF" class="falink" href="/papers/marc3_poster.pdf"><i class="fa fa-file-pdf-o"/></i></a>

> Task parallel programming has become a popular and effective approach for
> programming multicore systems. An interesting question is always how to
> implement the task abstraction on a new architecture. In this short paper,
> we look at Intel’s Single-Chip Cloud Computer (SCC) and propose a tasking
> environment for the SCC. We compare two different runtime systems with
> work-sharing and work-stealing schedulers.
</font>

**Adaptive Work-Splitting: Efficient Loop Scheduling for Task Parallel
  Programming**  
<font size="3">
with Ralf Hoffmann and Thomas Rauber, 2011 |
<a title="PDF" class="falink" href="/papers/work_splitting_2011.pdf"><i class="fa fa-file-pdf-o"/></i></a>

> As task-centric programming models become more widely used, we are seeing an
> increasing number of applications that take advantage of fine-grained
> parallelism. Programmers are encouraged to expose as much parallelism as
> possible and let the compiler and runtime system decide what parallelism is
> useful for a given target architecture. In the case of loop parallelism, it
> is natural to declare independent iterations as parallel, but doing so calls
> for a runtime scheduler that is capable of combining iterations and reducing
> loop scheduling overheads. In this paper, we build on the idea of using
> Lazy Binary Splitting (LBS) for scheduling arbitrary loop parallelism in
> task parallel runtime systems. LBS-based loop scheduling integrates well
> with existing work-stealing schedulers and eliminates the need for chunking
> to find a good trade-off between load balance and runtime overheads. We
> extend LBS with different work-splitting strategies, including guided,
> adaptive, and distributed splitting, for improved performance on a wide
> range of parallel loops. Ease of implementation and efficient use of
> fine-grained parallelism make a case for including work-splitting techniques
> in future runtime systems.
</font>

**Task Parallel Programming on the Cell Processor**  
<font size="3">
it - Information Technology, Volume 53, Number 2, Pages 76--83, 2011 |
<a title="DOI" class="falink" href="http://dx.doi.org/10.1524/itit.2011.0628"><i class="fa fa-external-link"/></i></a>

> Parallel programming with tasks---task parallel programming---is a promising
> approach to simplifying multithreaded programming in the chip multiprocessor
> (CMP) era. Tasks are used to describe independent units of work that can
> be assigned to threads at runtime in a way that is transparent to the
> programmer. Thus, the programmer can concentrate on identifying tasks and
> leave it to the runtime system to take advantage of the potential
> parallelism. Supporting the task abstraction on heterogeneous CMPs is more
> challenging than on conventional CMPs. In this article, we take a look at a
> lightweight task model and its implementation on the Cell processor, the
> most prominent heterogeneous CMP available today. Choosing a simple task
> model over a more complex one makes it possible to target fine-grained
> parallelism and still improve much in terms of programmability.
</font>

**Exploiting Fine-Grained Parallelism on Cell Processors**  
<font size="3">
with Ralf Hoffmann and Thomas Rauber, Euro-Par 2010 |
<a title="DOI" class="falink" href="http://dx.doi.org/10.1007/978-3-642-15291-7_18"><i class="fa fa-external-link"/></i></a>

> Driven by increasing specialization, multicore integration will soon enable
> large-scale chip multiprocessors (CMPs) with many processing cores. In order
> to take advantage of increasingly parallel hardware, independent tasks must
> be expressed at a fine level of granularity to maximize the available
> parallelism and thus potential speedup. However, the efficiency of this
> approach depends on the runtime system, which is responsible for managing
> and distributing the tasks. In this paper, we present a hierarchically
> distributed task pool for task parallel programming on Cell processors. By
> storing subsets of the task pool in the local memories of the Synergistic
> Processing Elements (SPEs), access latency and thus overheads are greatly
> reduced. Our experiments show that only a worker-centric runtime system that
> utilizes the SPEs for both task creation and execution is suitable for
> exploiting fine-grained parallelism.
</font>

**Dynamic Task Scheduling and Load Balancing on Cell Processors**  
<font size="3">
with Ralf Hoffmann and Thomas Rauber, PDP 2010 |
<a title="DOI" class="falink" href="http://dx.doi.org/10.1109/PDP.2010.24"><i class="fa fa-external-link"/></i></a>

> The shift to multicore processors demands efficient parallel programming on
> a diversity of architectures, including homogeneous and heterogeneous chip
> multiprocessors (CMPs). Task parallel programming is one approach that maps
> well to CMPs. In this model, the programmer focuses on identifying parallel
> tasks within an application, while a runtime system takes care of managing,
> scheduling, and balancing the tasks among a number of processors or cores.
> Heterogeneous CMPs, such as the Cell Broadband Engine, present new
> challenges to task parallel programming and corresponding runtime systems.
> In this paper, we present a library based on task pools for dynamic task
> scheduling and load balancing on Cell processors. In contrast to other
> approaches, our task pools include support for creating tasks using the
> Synergistic Processing Elements (SPEs), which enables the implementation of
> a wide range of task parallel applications. Our experiments show that task
> pools provide flexible and efficient support for task parallel programming
> on Cell processors. In addition, we show that offloading the process of task
> creation from the PPE to the SPEs provides much potential for exploiting
> fine-grained parallelism.
</font>
