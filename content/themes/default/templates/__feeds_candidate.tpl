<div class="job-candidate-wrapper">
  <div class="job-candidate-header">
    <div class="job-candidate-avatar">
      <a class="post-avatar-picture large" href="{$system['system_url']}/{$candidate['user_name']}" style="background-image:url({$candidate['user_picture']});"></a>
    </div>
    <div class="job-candidate-info">
      <div class="name">
        <a href="{$system['system_url']}/{$candidate['user_name']}">{$candidate['name']}</a>
      </div>
      <div class="row mb10">
        <div class="col-md-6">
          <i class="fas fa-map-marker-alt fa-fw mr5" style="color: #1f9cff;"></i>{$candidate['location']}
        </div>
        <div class="col-md-6">
          <i class="fas fa-clock fa-fw mr5" style="color: #ffc107;"></i><span class="js_moment" data-time="{$candidate['applied_time']}">{$candidate['applied_time']}</span>
        </div>
      </div>
      <div class="row mb10">
        <div class="col-md-6">
          <i class="fas fa-phone-alt fa-fw mr5" style="color: #2bb431;"></i>{$candidate['phone']}
        </div>
        <div class="col-md-6">
          <i class="fas fa-envelope fa-fw mr5" style="color: #009688;"></i>{$candidate['email']}
        </div>
      </div>
      <div>
        <!-- message -->
        <button type="button" class="btn btn-sm btn-primary rounded-pill js_chat-start" data-uid="{$candidate['user_id']}" data-name="{if $system['show_usernames_enabled']}{$candidate['user_name']}{else}{$candidate['user_firstname']} {$candidate['user_lastname']}{/if}" data-link="{$candidate['user_name']}">
          <i class="fa fa-comments mr5"></i>{__("Message")}
        </button>
        <!-- message -->
      </div>
    </div>
  </div>
  <div class="divider mtb20"></div>
  <div class="job-question">
    <div class="mb10">
      <div class="question">{__("Where did you work?")}</div>
      <div class="answer">{$candidate['work_place']}</div>
    </div>
    <div class="row mb10">
      <div class="col-md-4">
        <div class="question">{__("Position")}</div>
        <div class="answer">{$candidate['work_position']}</div>
      </div>
      <div class="col-md-4">
        <div class="question">{__("From")}</div>
        <div class="answer">{$candidate['work_from']}</div>
      </div>
      <div class="col-md-4">
        <div class="question">{__("To")}</div>
        <div class="answer">{if $candidate['work_now']}{__("Till Now")}{else}{$candidate['work_to']}{/if}</div>
      </div>
    </div>
    <div class="question">{__("Description")}</div>
    <div class="answer">{$candidate['work_description']}</div>
  </div>
  <!-- questions -->
  {if $candidate['question_1_title'] || $candidate['question_2_title'] || $candidate['question_3_title']}
    <div class="divider mtb20"></div>
    <div>
      <!-- question #1 -->
      {if $candidate['question_1_title']}
        <div class="job-question">
          <div class="question">{$candidate['question_1_title']}</div>
          <div class="answer">
            {$candidate['question_1_answer']}
          </div>
        </div>
      {/if}
      <!-- question #1 -->
      <!-- question #2 -->
      {if $candidate['question_2_title']}
        <div class="job-question">
          <div class="question">{$candidate['question_2_title']}</div>
          <div class="answer">
            {$candidate['question_2_answer']}
          </div>
        </div>
      {/if}
      <!-- question #2 -->
      <!-- question #3 -->
      {if $candidate['question_3_title']}
        <div class="job-question">
          <div class="question">{$candidate['question_3_title']}</div>
          <div class="answer">
            {$candidate['question_3_answer']}
          </div>
        </div>
      {/if}
      <!-- question #3 -->
    </div>
  {/if}
  <!-- questions -->
</div>