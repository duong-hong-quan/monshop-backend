﻿using Newtonsoft.Json;

namespace Monshop.BackEnd.Service.Services;

public class NotificationModel
{
    [JsonProperty("deviceId")] public string DeviceId { get; set; }

    [JsonProperty("isAndroidDevice")] public bool IsAndroidDevice { get; set; }

    [JsonProperty("title")] public string Title { get; set; }

    [JsonProperty("body")] public string Body { get; set; }
}

public class GoogleNotification
{
    [JsonProperty("priority")] public string Priority { get; set; } = "high";

    [JsonProperty("data")] public DataPayload Data { get; set; }

    [JsonProperty("notification")] public DataPayload Notification { get; set; }

    public class DataPayload
    {
        [JsonProperty("title")] public string Title { get; set; }

        [JsonProperty("body")] public string Body { get; set; }
    }
}