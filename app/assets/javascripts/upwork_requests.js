Vue.http.interceptors.push({
  request: function (request) {
    Vue.http.headers.common['X-CSRF-Token'] = $('[name="csrf-token"]').attr('content');
    return request;
  },
  response: function (response) {
    return response;
  }
});

var upworkRequestResource = Vue.resource('/upwork_requests{/id}.json')

Vue.component('upwork_request-row', {
  template: '#upwork_request-row',
  props: {
    upwork_request: Object
  },
  data: function () {
    return {
      editMode: true,
      errors: {}
    }
  },
  methods: {
    updateUpworkRequest: function () {
      var that = this;
        upworkRequestResource.update({id: that.upwork_request.id}, {upwork_request: that.upwork_request}).then(
        function(response) {
          that.errors = {}
          that.upwork_request = response.data
          that.editMode = true
        },
        function(response) {
          that.errors = response.data.errors
        }
      )
    }
  }
})

var upwork_requests = new Vue({
  el: '#upwork_requests',
  data: {
    upwork_requests: [],
    upwork_request: {
      name: '',
      email: '',
      profile_url: '',
      message: ''
    },
    errors: {}
  },
  ready: function() {
    var that;
    that = this;
      upworkRequestResource.get().then(
      function (response) {
        that.upwork_requests = response.data
      }
    )
  },
    methods: {
        createUpworkRequest: function () {
            var that = this;
            upworkRequestResource.save({upwork_request: this.upwork_request}).then(
                function(response) {
                    that.errors = {};
                    that.upwork_request = {};
                    that.upwork_requests.push(response.data);
                },
                function(response) {
                    that.errors = response.data.errors
                }
            )
        }
    }
});
