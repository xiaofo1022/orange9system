(function() {
    var num = 60;
    var controlTitle = $('#sample-pb .num-progress-title').text('本月进度（共100单）');
    var controlBar = $('#sample-pb .number-pb').NumberProgressBar({
      duration: 12000,
      current: num
    });
})();