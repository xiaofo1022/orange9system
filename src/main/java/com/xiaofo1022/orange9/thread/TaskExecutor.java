package com.xiaofo1022.orange9.thread;

import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;

public class TaskExecutor {
	private ThreadPoolTaskExecutor taskExecutor;
	
	public void execute(Runnable r) {
		taskExecutor.execute(new Thread(r));
	}

	public ThreadPoolTaskExecutor getTaskExecutor() {
		return taskExecutor;
	}

	public void setTaskExecutor(ThreadPoolTaskExecutor taskExecutor) {
		this.taskExecutor = taskExecutor;
	}
}
